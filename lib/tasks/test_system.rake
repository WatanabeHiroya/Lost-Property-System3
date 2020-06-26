namespace :test_system do
  desc "出発時間にメール送信"
  task test: :environment do
    #ここから処理を書いていく
    #定期実行する際に、そのログを取っておくのは大事。ログがないと定期実行でエラーが起きても分からない。
    logger = Logger.new 'log/test.log'
 
    Plan.all.each do |plan| 
      # 出発時間を過ぎたら処理
      if plan.departure_at < Time.zone.now && plan.send_mail == "0"
        begin
          # 処理
          plan.send_mail = "1"
          plan.save(validate: false)
          user = User.find(plan.user_id)
          
          # ここから修正
          if user.provider == "line"
            @no_check_items = []
            plan.checklists.each do |c|
              @no_check_items << c.item if c.check == "0"
            end
            if @no_check_items.present?
              messages = []
                messages << {
                  type: 'text',
                  text: "#{plan.subject}の出発予定時間のご連絡\n忘れ物があります！\n"
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
                text: "#{plan.subject}の出発予定時間のご連絡\n忘れ物はございません。\nいってらっしゃいませ！"
              }
            end
            client = Line::Bot::Client.new { |config|
              config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
              config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
            }
            response = client.push_message(user.uid, messages)
            p response
          else
            LostPropertyMailer.send_mail(plan).deliver
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