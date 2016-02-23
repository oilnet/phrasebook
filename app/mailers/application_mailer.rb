class ApplicationMailer < ActionMailer::Base
  default from: "noreply@phrasebook.weitnahbei.de" # TODO: Muss Einstellung sein!
  layout 'mailer'
end
