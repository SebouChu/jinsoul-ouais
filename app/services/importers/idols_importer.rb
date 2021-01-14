module Importers
  class IdolsImporter
    XLSX_FILE_URL = 'https://jinsoul-ouais.s3.eu-west-3.amazonaws.com/jinsoul-stuff.xlsx'.freeze

    def self.execute
      new
    end

    def initialize
      @errors = []
      @imported_count = 0
      analyze_xlsx
      display_errors
    end

    protected

    def analyze_xlsx
      xlsx.each.with_index do |hash, index|
        next if index == 0 # Column labels
        analyze_hash(hash, index)
      end if xlsx
    end

    def analyze_hash(hash, index)
      hash_to_idol = HashToIdol.new(hash)
      if hash_to_idol.valid?
        @imported_count += 1
      else
        @errors << { line: index + 1, error: hash_to_idol.error }
      end
    end

    def display_errors
      @errors.each { |error| puts "Line #{error[:line]}: #{error[:error]}" }
      puts "#{@imported_count} idol(s) imported successfully."
    end

    def xlsx
      @xlsx ||= begin
        xlsx = Roo::Spreadsheet.open(XLSX_FILE_URL, extension: :xlsx)
        begin xlsx.info
          # ensure we can access basic infos on the excel file. If not the file was incorrect
        rescue
          @errors << { line: 0, error: 'Unable to analyse the xlsx file.' }
          xlsx = nil
        end
        xlsx
      end
    end
  end

  class HashToIdol
    def initialize(hash)
      @hash = hash
      @error = nil
      extract_variables
      save if valid?
    end

    def valid?
      if !group.valid?
        @error = "Group #{@group_name} could not be created"
      elsif !idol.valid?
        @error = "Unable to create the idol: #{idol.errors.full_messages}"
      end
      @error.nil?
    end

    def error
      @error
    end

    protected

    def extract_variables
      @idol_name = @hash[0].to_s.strip
      @group_name = @hash[1].to_s.strip
    end

    def save
      idol.save
    end

    def group
      @group ||= Group.find_or_create_by(name: @group_name)
    end

    def idol
      @idol ||= Idol.find_or_create_by(name: @idol_name, group: @group)
    end
  end
end
