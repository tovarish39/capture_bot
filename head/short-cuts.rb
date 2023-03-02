# сокращения
CallbackClass  = Telegram::Bot::Types::CallbackQuery
MessageClass   = Telegram::Bot::Types::Message
UpdateMember   = Telegram::Bot::Types::ChatMemberUpdated

RM = ->(keyboard)           {Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard:keyboard, resize_keyboard:true)}
IM = ->(inline_keyboard)    {Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard:inline_keyboard)}
IB = ->(text, callback_data){Telegram::Bot::Types::InlineKeyboardButton.new(text:text, callback_data:callback_data)}

def send_message text, reply_markup = nil
  $bot.send_message(chat_id: $chat_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")
end

def delete_pushed message_id = $mes.message.message_id
  $bot.delete_message(chat_id:$chat_id, message_id:message_id)
end

def delete_text
  $bot.delete_message(chat_id:$chat_id, message_id:$mes.message_id)
end

def edit_message text, reply_markup = nil, message_id = nil
  message_id ||= $mes.message.message_id
  $bot.edit_message_text(chat_id: $chat_id, message_id:message_id, text:text, reply_markup:reply_markup, parse_mode:"HTML")
end

def send_photo path_to_photo
    $bot.send_photo(chat_id: $chat_id, photo: Faraday::UploadIO.new(path_to_photo, 'image/jpeg'))
end

def send_video path_to_video
  $bot.send_video(chat_id: $chat_id, video: Faraday::UploadIO.new(path_to_video, 'video/mp4'))
end

def comparing message, compare
    return true if !compare
    with_text  = compare.class == String
    with_regex = compare.class == Regexp 
    return true if with_text  && message == compare
    return true if with_regex && message =~ compare
    false
  end
    

def text_mes? compare = nil # сообщение text любое или соответствие сравниваемому
    return nil if $mes.class != MessageClass
    return nil if !$mes.text # для кнопки shared_user
    text = $mes.text
    comparing(text, compare)
 end
 
 def data?(compare = nil) # сообщение callback любое или соответствие сравниваемому
   return nil if $mes.class != CallbackClass
   data = $mes.data
   comparing(data, compare)
 end