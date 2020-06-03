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
          LostPropertyMailer.send_mail(plan).deliver

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