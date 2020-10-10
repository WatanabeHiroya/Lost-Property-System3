namespace :prior_system do
  desc "出発時間10分前にメール送信"
  task prior: :environment do
    #ここから処理を書いていく
    #定期実行する際に、そのログを取っておくのは大事。ログがないと定期実行でエラーが起きても分からない。
    logger = Logger.new 'log/prior.log'
 
    Plan.all.each do |plan| 
      # 出発時間15分前以内だったら
      if plan.departure_at - Time.zone.now <= 900 && plan.prior_send_mail == "0"
        begin
          # 処理
          plan.prior_send_mail = "1"
          plan.save(validate: false)
          user = User.find(plan.user_id)
          
          if user.provider == "line"
            @no_check_items = []
            plan.checklists.each do |c|
              @no_check_items << c.item if c.check == "0"
            end
            if @no_check_items.present?
              messages = []
                messages << {
                  type: 'text',
                  text: "#{plan.subject}の出発予定時間が迫っています\n忘れ物があります！\n"
                }
                @no_check_items.each do |item|
                  messages << {
                    type: 'text',
                    text: "・#{item}"
                  }
                end
            else
              messages = {
                type: 'text',
                text: "#{plan.subject}の出発予定時間が迫っています\n忘れ物はございません。"
              }
            end
            client = Line::Bot::Client.new { |config|
              config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
              config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
            }
            response = client.push_message(user.uid, messages)
            p response
          else
            LostPropertyMailer.prior_send_mail(plan).deliver
          end


        rescue => e
          #何かしらエラーが起きたら、エラーログの書き込み ただし次のユーザーの処理へは進む
          logger.error "plan_id: #{plan.id}でエラーが発生"
          logger.error e
          logger.error e.backtrace.join("\n")
          next
        end
      end
    end
  end
end