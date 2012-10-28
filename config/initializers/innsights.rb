# Extensive Docs at http://github.com/innku/innsights-gem

Innsights.setup do
   user :User

   watch User do
     report "Nuevo usuario"
     upon :after_create
   end

   watch Link do
     report  "Nuevo link"
     user    :user
     upon    :after_create
   end

  config :test do
    enable :false
  end
end
