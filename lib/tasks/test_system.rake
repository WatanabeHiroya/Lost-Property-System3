namespace :test_system do
  desc "これはテストです。"
  task test: :environment do
    #ここから処理を書いていく
    #定期実行する際に、そのログを取っておくのは大事。ログがないと定期実行でエラーが起きても分からない。
    logger = Logger.new 'log/test.log'
 
    @plans = Plan.all
    @plans.each do |p| 
      if p.departure_at < Time.zone.now
        begin
          # 処理を記述
          user = User.find(2)
          user.update_attributes!(name: "!!!")
   
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