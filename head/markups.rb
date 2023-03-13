IB_ru = ->{IB.call("🇷🇺 Русский 🇷🇺", "ru/выбранный язык")}
IB_en = ->{IB.call("🇺🇸 English 🇺🇸", "en/выбранный язык")}
IB_es = ->{IB.call("🇪🇸 Español 🇪🇸", "es/выбранный язык")}
IB_cn = ->{IB.call("🇨🇳 中國語文 🇹🇼",  "cn/выбранный язык")}
IB_fr = ->{IB.call("🇫🇷 Français 🇫🇷", "fr/выбранный язык")}

Rand_smile = ->{Smiles_other[rand(Smiles_other.size - 1)]}
IBs_smiles = ->(line){
    buttons = []
    line.each do |obj|
        smile   = obj.keys.first
        boolean = obj.values.first
        buttons <<  IB.call(smile,           "#{$lg}/#{boolean}/#{$action_to}" )
    end
    buttons
}


Smile_lines = {
    bear:    [{'🐻'=>'true'},  {'🦈'=>'false'}, {'🦐'=>'false'}, {'🐞'=>'false'}],
    turtle:  [{'🦨'=>'false'}, {'🐢'=>'true'},  {'🦕'=>'false'}, {'🐛'=>'false'}],
    dino:    [{'🦌'=>'false'}, {'🦀'=>'false'}, {'🦕'=>'true'},  {'🦫'=>'false'}],
    whale:   [{'🐳'=>'true'},  {'🦖'=>'false'}, {'🐂'=>'false'}, {'🦔'=>'false'}],
    chicken: [{'🐥'=>'true'},  {'🐵'=>'false'}, {'🐼'=>'false'}, {'🐶'=>'false'}],
    kitten:  [{'🐔'=>'false'}, {'🐱'=>'true'},  {'🕷'=>'false'}, {'🐙'=>'false'}],
    cow:     [{'🐄'=>'true'},  {'🦧'=>'false'}, {'🐠'=>'false'}, {'🐜'=>'false'}],
    horse:   [{'🦫'=>'false'}, {'🐇'=>'false'}, {'🦙'=>'false'}, {'🦄'=>'true'}],
    crab:    [{'🐺'=>'false'}, {'🐒'=>'false'}, {'🦀'=>'true'},  {'🐝'=>'false'}],
    dog:     [{'🦏'=>'false'}, {'🐩'=>'true'},  {'🦧'=>'false'}, {'🪱'=>'false'}]  
}


IM_langs        = ->{IM.call([IB_ru.call, IB_en.call, IB_es.call, IB_cn.call, IB_fr.call])}
IM_smiles       = ->(line){IM.call([IBs_smiles.call(line).sort_by{ rand } ])}
IM_chat_link    = ->(link){IM.call(IB.call(T_chat[$lg], nil, link))}
IM_channel_link = ->(link){IM.call(IB.call(T_channel[$lg], nil, link))}


T_chat = {
    ru:'Kozmap\'s Gang чат',
    en:'Kozmap\'s Gang Chat',
    es:'"Kozmap\'s Gang" Chat',
    cn:'“Kozmap Gang” 聊天',
    fr: '"Kozmap Gang" Chat'
}

T_channel = {
    ru:'Канал Kozmap\'a',
    en:'Kozmap\'s Scans Service Channel',
    es:'Channel de Kozmap',
    cn:'Kozmap 的主頻道',
    fr:'Canal de service de Kozmap'
}


IM_offer_links = {
    ru:->{IM.call([
        IB.call(T_chat[$lg], "ru/запрос_на_чат"), 
        IB.call(T_channel[$lg],    "ru/запрос_на_канал")
        ])},
    en:->{IM.call([
        IB.call(T_chat[$lg],             "en/запрос_на_чат"), 
        IB.call(T_channel[$lg], "en/запрос_на_канал")
        ])},
    es:->{IM.call([
        IB.call(T_chat[$lg], "es/запрос_на_чат"), 
        IB.call(T_channel[$lg],     "es/запрос_на_канал")
        ])},
    cn:->{IM.call([
        IB.call(T_chat[$lg],     "cn/запрос_на_чат"), 
        IB.call(T_channel[$lg],         "cn/запрос_на_канал")
        ])},
    fr:->{IM.call([
        IB.call(T_chat[$lg],         "fr/запрос_на_чат"), 
        IB.call(T_channel[$lg], "fr/запрос_на_канал")
        ])}
}