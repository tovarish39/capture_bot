require 'telegram/bot'
Groupe_id            = -1001632706756
Channel_id           = -1001176838228
# Channel_id           = '-1001176838228'
My_chat_id = '1964112204'

token                = ENV["Capture_bot"]
Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        $bot = bot.api      
        $mes = message      

        res_chat = $bot.create_chat_invite_link(
            chat_id:Channel_id,
            member_limit:1,
            expire_date: Time.now.to_i + 60
        )
        puts res_chat
    end
end