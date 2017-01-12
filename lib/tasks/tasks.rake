DATACODE_MAILERBOT_EMAIL_BODY_NO_ENTRIES = <<eos

Hello,

There was no new activity related to Group Codes over the past twenty-four hours.


Yours Digitally,
GroupCode Data Mailbot

eos
DATACODE_MAILERBOT_EMAIL_BODY_NO_ENTRIES.strip!

DATACODE_MAILERBOT_EMAIL_BODY = <<eos

Hello,

Attached are the past twenty-four hours' requested activity regarding GroupCodes in SQL.


Yours Digitally,
GroupCode Data Mailbot

eos
DATACODE_MAILERBOT_EMAIL_BODY.strip!

namespace :scheduler do
  desc 'Send Group Code data to headquarters'
  task :send_group_code_data => :environment do
    require 'zip'

    zipfile_name = "recent-group-code-data-#{Time.now.utc}.zip"
    Zip.sort_entries = true


    if Rails.env.development? || Rails.env.test?
      logfile_path = STDOUT
      recipient_email_address = 'ross.wittenberg@gmail.com'
      recipient_name          = 'Ross'
    else
      # recipient_email_address = 'ross.wittenberg@gmail.com'
      # recipient_name          = 'Ross'
      recipient_email_address = 'Sam.Wachel@alsformalwear.com'
      recipient_name          = 'Sam Wachel'
      logfile_path = File.dirname(__FILE__) + "/../../log/scheduler-groupcode.log"
    end

    logger = ActiveRecord::Base.logger = Logger.new logfile_path

    logger.info "**********************************"
    logger.info "Starting task at #{Time.now}"
    logger.info "**********************************"

    locations = Location.includes(:events => :group_code).all #force query —JC
    logger.info "Found #{locations.length} Locations, with #{locations.collect(&:events).flatten.length} Events in total. However, only records with recent activity regarding GroupCodes are sent by this bot."

    # VERY SUBOPTIMAL FIXTURES/FACTORIES SUBSTITUTES
    # locations.first.events.each {|e| e.group_code = GroupCode.create } # REMOVE

    tempdir = Dir.mktmpdir(
      'scheduler-groupcode',
      File.expand_path(File.join(File.dirname(__FILE__), '/../../tmp')))
    logger.debug "Created fresh temporary directory at #{tempdir}"

    Dir.chdir tempdir do
      locations.each do |location|
        if (sql = location.nightly_group_export).blank?
          logger.debug "Skipped processing of Location #{location.id} because no new data"
          next
        end

        logger.debug "Started processing Location #{location.id}"
        File.open "#{location.shorthand}-#{Date.today.strftime('%Y%m%d')}", 'w' do |sql_file|
          sql_file.write sql unless sql.blank?
        end
      end

      sql_filenames = Dir.glob '*'
      logger.info "Packing the following files into zipfile \"#{zipfile_name}\": #{sql_filenames}"

      if sql_filenames.blank?
        message = {
          to: [{
            type:  'to',
            name:  recipient_name,
            email: recipient_email_address
          }],
          text: DATACODE_MAILERBOT_EMAIL_BODY_NO_ENTRIES,
          subject: "DataCode activity SQL for #{Date.yesterday.to_s(:long_ordinal)}",
          from_name: "Al's Formalwear GroupCode Data Mailbot",
          from_email: 'groupcode-databot@verbalplusvisual.com',
        }
      else
        # # POS Main file
        posmain_file_name = "posmain-#{Date.tomorrow.strftime('%Y%m%d')}"

        Zip::File.open zipfile_name, Zip::File::CREATE do |zipfile|
          
          File.open posmain_file_name, 'w' do |posmain|
            posmain.write Event.convert_to_pos_main_string_for_export
          end

          sql_filenames.each do |sql_filename|
            zipfile.add sql_filename, sql_filename
          end
          zipfile.add posmain_file_name, posmain_file_name
        end

        message = {
          to: [{
            type:  'to',
            name:  recipient_name,
            email: recipient_email_address
          },
          {
            type:  'cc',
            name:  "Caroline Molloy",
            email: "caroline@verbalplusvisual.com"
          }],
          text: DATACODE_MAILERBOT_EMAIL_BODY,
          subject: "DataCode activity SQL for #{Date.yesterday.to_s(:long_ordinal)}",
          from_name: "Al's Formalwear GroupCode Data Mailbot",
          from_email: 'groupcode-databot@verbalplusvisual.com',
          attachments: [{
            content: Base64.encode64(File.read(zipfile_name)),
            name: "groupcode-activity-#{Date.yesterday.to_s(:iso8601)}.zip",
            type: 'application/zip'
          }]
        }
      end  
      MANDRILL.messages.send message
    end

    logger.info "An e-mail with the zip file has been sent to #{recipient_name} at address \"#{recipient_email_address}\"."

    logger.info "**********************************"
    logger.info "Task ended without throwing an exception at #{Time.now}"
    logger.info "**********************************"
  end
end

namespace :scheduler do
  desc 'Confirm all users'
  task :confirm_all_users => :environment do
    Spree::User.all.map(&:confirm)
  end
end

# namespace :scheduler do
#   desc "Send POS MAIN SQL for #{Date.yesterday.strftime('%Y%m%d')}"
#   task :send_pos_main => :environment do
#   text = Event.convert_to_pos_main_string_for_export
#   message = {
#     to: [{
#       type:  'to',
#       name:  "Sam Wachel",
#       email: 'Sam.Wachel@alsformalwear.com'
#     },
#     {
#       type:  'cc',
#       name:  "Alyssa Kaplan",
#       email: "alyssa@verbalplusvisual.com"
#     },
#     {
#       type:  'cc',
#       name:  "Caroline Molloy",
#       email: "caroline@verbalplusvisual.com"
#     }
#     ],
#     text: text,
#     subject: "posmain-#{Date.yesterday.strftime('%Y%m%d')}",
#     from_name: "Al's Formalwear POS Main Data Mailbot",
#     from_email: 'alyssa@verbalplusvisual.com',
#   }
#   MANDRILL.messages.send message
#   end
# end 
