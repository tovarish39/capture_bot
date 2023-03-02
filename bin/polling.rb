require "#{__dir__}/../head/requires.rb"


bot_main_chat_id     = '5676653907'
bot_capture_chait_id = '5965916617'
token                = ENV["Capture_bot"]
Groupe_id            = '-831562777'

def sending_photo_with_smiles
    images_path = "#{__dir__}/../images"
    photos = Dir.entries(images_path)
    photo_name_full = photos[rand(photos.size - 1)]
    photo_name = photo_name_full.split('.').first
    corresponding_smile_line = Smile_lines[photo_name.to_sym]
    
    path_to_photo = images_path + "/" + photo_name_full
    send_photo(path_to_photo)

    send_message(B_choose_corresponding_animal[$lg], IM_smiles.call(corresponding_smile_line))
end

def handle_lang
    $lg = $mes.data.split('/').first.to_sym
    delete_pushed()
    video_path = "#{__dir__}/../video/video.mp4"
    send_video(video_path)
    send_message(B_capture_info[$lg])
    sending_photo_with_smiles()
end

def success
    res = $bot.create_chat_invite_link(
        chat_id:Groupe_id,
        member_limit:1,
        expire_date: Time.now.to_i - 3600
    )
     
    lg = $mes.data.split('/').first.to_sym

    invite_link = "<a href='#{res['result']['invite_link']}'>\"Link\"</a>"
    
    text =  B_successs_head[lg]
    text << invite_link
    text << "\n"
    text << B_successs_tail[lg]

    send_message(text)
end

def failure
    $lg = $mes.data.split('/').first.to_sym
    delete_pushed()
    sending_photo_with_smiles()
end

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        $mes = message        
        $bot = bot.api
        $chat_id = $mes.class == MessageClass ? $mes.chat.id : $mes.message.chat.id

        from_group = $mes.class == MessageClass ? $mes.chat.type == 'group' : $mes.message.chat.type == 'group'

        unless from_group  
    puts 'come'
            if    text_mes?('/start')
                send_message(B_choose_lang, IM_langs.call)
            elsif data?(/выбранный язык/); handle_lang()
            elsif data?(/true/)          ; success()
            elsif data?(/false/)         ; failure()
            end
        end

    end
end