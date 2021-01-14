namespace :app do
  namespace :import do
    desc 'Import groups & idols from remote Excel file'
    task :idols do
      Importers::IdolsImporter.execute
    end
  end
end