require "#{__dir__}/../head/requires.rb"


bot_main_chat_id     = '5676653907'
bot_capture_chait_id = '5965916617'
token                = ENV["Capture_bot"]
# Groupe_id            = '-831562777'
Groupe_id            = '-1001632706756'

Channel_id           = '-1001176838228'

def sending_photo_with_smiles
    images_path = "#{__dir__}/../images"
    photos = Dir.entries(images_path)
    photos -= ['.']  if photos.include?('.')
    photos -= ['..'] if photos.include?('..')
    photo_name_full = photos[rand(photos.size - 1)]
    photo_name = photo_name_full.split('.').first

    corresponding_smile_line = Smile_lines[photo_name.to_sym]
    
    path_to_photo = images_path + "/" + photo_name_full
    send_photo(path_to_photo)

    send_message(B_choose_corresponding_animal[$lg], IM_smiles.call(corresponding_smile_line))
end

def handle_lang
    $lg = $mes.data.split('/').first.to_sym

    edit_message(B_greeting[$lg], IM_offer_links[$lg].call)
    
    # edit_message(B_capture_info[$lg])
    # sending_photo_with_smiles()
end

def success_for_chat
    begin
        delete_pushed()
    rescue => exception
        
    end
    res = $bot.create_chat_invite_link(
        chat_id:Groupe_id,
        member_limit:1,
        expire_date: Time.now.to_i + 60
    )
     
    lg = $mes.data.split('/').first.to_sym
    invite_link = res['result']['invite_link']
    
    send_message(
        B_successs[lg], 
        IM_chat_link.call(invite_link)
    )
end

def success_for_channel
    begin
        delete_pushed()
    rescue => exception
        
    end
    res = $bot.create_channel_invite_link(
        chat_id:Channel_id,
        member_limit:1,
        expire_date: Time.now.to_i + 60
    )
     
    $lg = $mes.data.split('/').first.to_sym
    invite_link = res['result']['invite_link']
    
    send_message(
        B_successs[$lg], 
        IM_channel_link.call(invite_link)
    )
end

def failure_for_chat
    begin
        delete_pushed()
    rescue => exception
        
    end
    $action_to = 'капча_для_чата'
    $lg = $mes.data.split('/').first.to_sym
    sending_photo_with_smiles()
end

def failure_for_channel
    begin
        delete_pushed()
    rescue => exception
        
    end
    $action_to = 'капча_для_канала'
    $lg = $mes.data.split('/').first.to_sym
    sending_photo_with_smiles()
end

def starting
    video_path = "#{__dir__}/../video/video.mp4"
    send_video(video_path)
    send_message(B_choose_lang, IM_langs.call)
end

def returning
    return
end

def get_capture_for_chat
    $lg = $mes.data.split('/').first.to_sym
    $action_to = 'капча_для_чата'
    getting_capture(B_to_chat[$lg])
end

def getting_capture text
    edit_message(text)
    sending_photo_with_smiles()
end

def get_capture_for_channel    
    $lg = $mes.data.split('/').first.to_sym
    $action_to = 'капча_для_канала'
    getting_capture(B_to_channel[$lg])
end


Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        $mes = message        
        $bot = bot.api
# только для текстовых сообщений и callback
        if    $mes.class == MessageClass
            $chat_id = $mes.chat.id
            from_group = $mes.chat.type == 'supergroup'
            # from_group = $mes.chat.type == 'group'
        elsif $mes.class == CallbackClass
            $chat_id = $mes.message.chat.id
            from_group = $mes.message.chat.type == 'supergroup'
            # from_group = $mes.message.chat.type == 'group'
        end
# puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
# puts $mes.inspect
# puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
# puts $mes.chat.type
# puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!'




        if    !$chat_id;                 ; returning()                    
        # elsif true;                 ; returning()                    
        elsif !from_group
puts $mes.data
puts data?(/true\/капча_для_канала/)
puts data?(/false\/капча_для_канала/)

            if    text_mes?('/start')    ; starting()

            elsif data?(/запрос_на_чат/)            ; get_capture_for_chat()
            elsif data?(/true\/капча_для_чата/)     ; success_for_chat()
            elsif data?(/false\/капча_для_чата/)    ; failure_for_chat()
                
            elsif data?(/запрос_на_канал/)            ; get_capture_for_channel()
            elsif data?(/true\/капча_для_канала/)     ; success_for_channel()
            elsif data?(/false\/капча_для_канала/)    ; failure_for_channel()
            

            # elsif data?(/true/)          ; success()
            # elsif data?(/false/)         ; failure()
            elsif data?(/выбранный язык/); handle_lang()
            end
        end

    end
end
