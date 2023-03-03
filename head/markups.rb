IB_ru = ->{IB.call("🇷🇺Русский🇷🇺", "ru/выбранный язык")}
IB_en = ->{IB.call("🇺🇸English🇺🇸", "en/выбранный язык")}
IB_es = ->{IB.call("🇪🇸Español🇪🇸", "es/выбранный язык")}

Rand_smile = ->{Smiles_other[rand(Smiles_other.size - 1)]}
IBs_smiles = ->(line){
    buttons = []
    line.each do |obj|
        smile   = obj.keys.first
        boolean = obj.values.first
        buttons <<  IB.call(smile,           "#{$lg}/#{boolean}" )
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

# Smiles_capture = {
#     bear:   '🐻',
#     chicken:'🐥',
#     cow:    '🐄',
#     crab:   '🦀',
#     dino:   '🦕',
#     dog:    '🐩',
#     horse:  '🦄',
#     kitten: '🐱',
#     turtle: '🐢',
#     whale:  '🐳'  
# }
# Smiles_other = ['🦈', '🦐', '🐞', '🦨', '🐛', '🦌', '🦖', '🐂', '🦔', '🐵', '🐼', '🐶', '🐔', '🕷', '🐙', '🐠', '🐜', '🦫', '🐇', '🦙', '🐺', '🐒', '🐝', '🦏', '🦧', '🪱']




IM_langs   = ->{IM.call([IB_ru.call, IB_en.call, IB_es.call])}
IM_smiles  = ->(line){IM.call([IBs_smiles.call(line).sort_by{ rand } ])}
IM_link    = ->(link)(IM.call(IB.call('Link', nil, link)))