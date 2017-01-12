# Location.destroy_all

require 'csv'

# csv_file_path = 'db/seeds/locations.csv'
# CSV.foreach(csv_file_path, :headers => true ) do |row|
#   Location.create!(row.to_hash)
# end

# GroupCode.destroy_all

# location_store_num_array = [2,5,6,17,18,301,304,305,307,308,310,311,312,314,315,316,317,502,503,504,507,508,509,510,511,512,515,517,603,605,606,608,611,613,614,615,701,702,704,707,708,710,714,717,718,719,720,721,722,724,727,729,730,733,734,736,743,749,751,753,754,758,761,762,764,766,771,774,776,784,785,786,788]
# location_group_code_starting_number = [1233612,1925319,2176795,4358422,4524099,4866529,5421507,5625028,6099381,6384829,6666612,6822951,7131483,7270502,7425008,7720986,8113744,28653778,28867376,29087132,29856548,30075675,30244838,30471220,30643886,30849244,34863171,35216360,31656356,32059623,32261395,32647176,33269138,33676367,33868248,34056336,5881287,8405469,8863256,9349105,9572793,9915218,10677734,11465366,11550446,11828297,12055011,12289516,12481597,12807806,13346969,13773217,14052708,14666929,14853925,15199701,16626523,17854164,18256915,18639011,18827116,19628259,20281320,20398545,20819336,21196359,24410832,22821921,23226461,25008835,25184306,25587157,28079749]

# i = 0
# j = 0
# while j < location_store_num_array.count
# 	current_location = Location.find_by_store_num location_store_num_array[j]
# 	while i <= 100
# 		GroupCode.create({ number: location_group_code_starting_number[j] + i, location_id: current_location.id })
# 		i += 1
# 	end
# 	i = 0
# 	j += 1
# end

# csv_file_path = 'db/seeds/high_schools.csv'
# CSV.foreach(csv_file_path, :headers => true ) do |row|
#   row["name"] = row["name"].strip
#   row["name_first_half"] = row["name_first_half"].strip
#   row["name_second_half"] = row["name_second_half"].strip
#   row["city"] = row["city"].strip
#   HighSchool.create!(row.to_hash)
# end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  ~~~~~~~~ parent colors ~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# parent_color_array = [
# 	{name: "whites", hex: '#f9f9f9', display_name: "Whites & Ivories" },
# 	{name: "grays", hex: '#c7c7c7', display_name: "Greys" },
# 	{name: "pinks", hex: '#e1b4b6', display_name: "Pinks" },
# 	{name: "reds", hex: '#801c20', display_name: "Reds" },
# 	{name: "oranges", hex: '#fdad6d', display_name: "Oranges & Corals" },
# 	{name: "yellows", hex: '#d7b900', display_name: "Yellows" },
# 	{name: "browns", hex: '#976816', display_name: "Browns & Tans" },
# 	{name: "greens", hex: '#2c6600', display_name: "Greens" },
# 	{name: "turquoise", hex: '#03c2be', display_name: "Turquoise & Teals" },
# 	{name: "blues", hex: '#080079', display_name: "Blues" },
# 	{name: "purples", hex: '#683588', display_name: "Purples" },
# 	{name: "blacks", hex: '#000000', display_name: "Blacks" },
# ]

# parent_color_array.each do |pc|
# 	ParentColor.create(pc)
# end
# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # ~~~~~~~~~~ child colors ~~~~~~~~~~~~
# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# whites_array = [
#   { name: "white", hex:'#ffffff' },
#   { name: "ivory", hex:'#f2eeeb' },
#   { name: "candelight", hex:'#f1eee9' },
#   { name: "ecru", hex:'#dcd3cc' }
# ]

# grays_array = [
#   { name: 'platinum', hex: '#c4ccce' },
#   { name: 'ice', hex: '#a1a3b2' },
#   { name: 'silver_spectrum', hex: '#969694' },
#   { name: 'silver', hex: '#5e5d5b' },
#   { name: 'charcoal', hex: '#4e4d55' },
#   { name: 'gray', hex: '#393939' }
# ]

# pinks_array = [
#   { name: 'blush', hex: '#f5ddd1' },
#   { name: 'petal_pink', hex: '#d8cecc' },
#   { name: 'pink', hex: '#dbbdbd' },
#   { name: 'rose', hex: '#daacae' },
#   { name: 'cerise', hex: '#dba6c2' },
#   { name: 'shrimp', hex: '#ca9a9a' },
#   { name: 'guava', hex: '#e28983' },
#   { name: 'bubble_gum', hex: '#d36b74' },
#   { name: 'hot_pink', hex: '#df46a8' },
#   { name: 'pomegranate', hex: '#d6134f' },
#   { name: 'fuchsia', hex: '#b8396e' },
#   { name: 'watermelon', hex: '#8b4b59' },
#   { name: 'magenta', hex: '#9b1f43' },
#   { name: 'azalea', hex: '#83304a' },
#   { name: 'sangria', hex: '#6b1e32' }	
# ]

# reds_array = [
# 	{ name: 'cherry', hex: '#e10436'},
#   { name: 'red', hex: '#ca2436'},
#   { name: 'fire_red', hex: '#c02422'},
#   { name: 'capri_red', hex: '#8b191e'},
#   { name: 'claret', hex: '#7b383f'},
#   { name: 'apple', hex: '#6a3133'},
#   { name: 'burgundy', hex: '#4e1c24'}
# ]

# oranges_array = [
#   { name: 'orange', hex:  '#eaa92d' },
#   { name: 'bright_orange', hex:  '#ed9166' },
#   { name: 'peach', hex:  '#d69965' },
#   { name: 'bali_peach', hex:  '#d79b65' },
#   { name: 'creamsicle', hex:  '#d4975c' },
#   { name: 'orange_crush', hex:  '#e26829' },
#   { name: 'persimmon', hex:  '#d85e4b' },
#   { name: 'coral', hex:  '#d45745' },
#   { name: 'tangerine', hex:  '#a94229' }
# ]
# yellows_array = [
#   { name: "sunflower", hex: '#f3d752' },
#   { name: "bright_canary", hex: '#f4cf43' },
#   { name: "midas_gold", hex: '#dfc79b' },
#   { name: "gold", hex: '#dbb489' },
#   { name: "yellow", hex: '#d2d38f' },
#   { name: "buttercup", hex: '#d1bd5c' },
#   { name: "canary", hex: '#ceaa3a' },
#   { name: "golden", hex: '#a79277' }
# ]
# browns_array = [
#   { name: 'biscotti', hex: '#ddcfcf' },
#   { name: 'straw', hex: '#cac2b5' },
#   { name: 'bamboo', hex: '#c9c1b6' },
#   { name: 'sand', hex: '#cdbaa9' },
#   { name: 'latte', hex: '#cca5a0' },
#   { name: 'champagne', hex: '#b28975' },
#   { name: 'cinnamon', hex: '#b37055' },
#   { name: 'mocha', hex: '#756158' },
#   { name: 'chocolate', hex: '#6a5655' },
#   { name: 'sienna', hex: '#7a342a' },
#   { name: 'espresso', hex: '#4d423c' },
#   { name: 'brown', hex: '#31302e' }	
# ]
# greens_array = [
#   { name: 'meadow', hex: '#d8e2d7' },
#   { name: 'seafoam', hex: '#bdd0cc' },
#   { name: 'honeydew', hex: '#b7c9a1' },
#   { name: 'key_lime', hex: '#c5d475' },
#   { name: 'lime', hex: '#9fd573' },
#   { name: 'clover', hex: '#80b599' },
#   { name: 'peridot', hex: '#919f7e' },
#   { name: 'kiwi', hex: '#949e5f' },
#   { name: 'emerald', hex: '#019678' },
#   { name: 'kelly', hex: '#136a26' },
#   { name: 'sage', hex: '#6a7b71' },
#   { name: 'pistachio', hex: '#606c54' },
#   { name: 'mossy_oak', hex: '#645f49' },
#   { name: 'jade', hex: '#3a7072' },
#   { name: 'mermaid', hex: '#016160' },
#   { name: 'hunter', hex: '#405e54' },
#   { name: 'olive', hex: '#222b08' },
#   { name: 'shamrock', hex: '#003d30' },
#   { name: 'holly', hex: '#0f1d1d' }
	
# ]
# turquoise_array = [
# 	{ name:'turquoise', hex: '#1894c7' },
# 	{ name:'mystic_teal', hex: '#1183b9' },
# 	{ name:'dark_turquoise', hex: '#0c95a7' },
# 	{ name:'gem', hex: '#228185' },
# 	{ name:'teal_oasis', hex: '#106677' },
# 	{ name:'pacific', hex: '#1b5e79' }	
# ]
# blues_array = [
#   { name: 'light_blue', hex: '#c8deeb' },
#   { name: 'spa', hex: '#aedee0' },
#   { name: 'cornflower', hex: '#88c5f2' },
#   { name: 'tiffany_blue', hex: '#70c7d1' },
#   { name: 'bali_blue', hex: '#5c7ea4' },
#   { name: 'peacock', hex: '#4a6f8c' },
#   { name: 'royal_blue', hex: '#4163b6' },
#   { name: 'sky_blue', hex: '#2d6d9b' },
#   { name: 'haze_blue', hex: '#505f7e' },
#   { name: 'blue_slate', hex: '#4e5663' },
#   { name: 'periwinkle', hex: '#3d4b72' },
#   { name: 'marine', hex: '#271b9b' },
#   { name: 'navy', hex: '#14154b' },
#   { name: 'blue', hex: '#27324e' },
#   { name: 'blue_velvet', hex: '#26273c' },
#   { name: 'midnight', hex: '#021128' }	
# ]
# purples_array = [
#   { name:'light_lavender', hex:'#c0a9c6' },
#   { name:'lavender', hex: '#b19dc0' },
#   { name:'heather', hex: '#8a739f' },
#   { name:'bali_lavender', hex:'#877494' },
#   { name:'wisteria', hex: '#9a8194' },
#   { name:'plum', hex: '#77485a' },
#   { name:'wine', hex: '#5f3038' },
#   { name:'aubergine', hex: '#50233a' },
#   { name:'grape', hex: '#545071' },
#   { name:'purple_passion', hex: '#483958' },
#   { name:'lapis', hex: '#41325d' },
#   { name:'dark_eggplant', hex:'#2c1e42' },
#   { name:'purple', hex: '#26172c' }	
	
# ]
# blacks_array = [
#   { name:'black', hex: '#000000' }	
# ]

# whites_array.each do |c|
# 	parent = ParentColor.find_by_name "whites"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# grays_array.each do |c|
# 	parent = ParentColor.find_by_name "grays"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# pinks_array.each do |c|
# 	parent = ParentColor.find_by_name "pinks"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# reds_array.each do |c|
# 	parent = ParentColor.find_by_name "reds"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# oranges_array.each do |c|
# 	parent = ParentColor.find_by_name "oranges"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# yellows_array.each do |c|
# 	parent = ParentColor.find_by_name "yellows"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# browns_array.each do |c|
# 	parent = ParentColor.find_by_name "browns"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# greens_array.each do |c|
# 	parent = ParentColor.find_by_name "greens"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# turquoise_array.each do |c|
# 	parent = ParentColor.find_by_name "turquoise"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# blues_array.each do |c|
# 	parent = ParentColor.find_by_name "blues"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# purples_array.each do |c|
# 	parent = ParentColor.find_by_name "purples"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# blacks_array.each do |c|
# 	parent = ParentColor.find_by_name "blacks"
# 	child = ChildColor.create c
# 	child.parent_color = parent
# 	child.save
# end

# csv_file_path = 'db/seeds/competitor_colors.csv'
# CSV.foreach(csv_file_path, :headers => true ) do |row|
# 	parent = ParentColor.find_by_name row["parent"]
#   row.delete "parent"
#   cc = CompetitorColor.create!(row.to_hash)
# 	cc.parent_color = parent
# 	cc.save
# end







