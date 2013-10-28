module SpreeOptionIsProduct
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        append_file "app/assets/javascripts/admin/all.js", "//= require admin/option_types\n"
      end
      def add_stylesheets
        append_file "app/assets/stylesheets/admin/all.css", " *= require admin/spree_option_is_product\n"
        append_file "app/assets/stylesheets/store/all.css", " *= require store/spree_option_is_product\n"
      end
      def add_migrations
        run 'rake railties:install:migrations from=spree_option_is_product'
      end
      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'rake db:migrate'
        else
          puts "Skiping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end
