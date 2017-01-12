COLOR_PAIRS = {}
Spree::Variant.all.each do |variant|
  parent_color = nil
  child_color = nil
  variant.option_values.each do |option_value|
    if option_value.option_type.name == 'parent_color'
      parent_color = option_value.name
    elsif option_value.option_type.name == 'child_color'
      child_color = option_value.name
    end
	  if COLOR_PAIRS[parent_color].present?
	    COLOR_PAIRS[parent_color] << child_color
	  else
	    COLOR_PAIRS[parent_color] = [child_color]
	  end
  end
end
COLOR_PAIRS.each do |k, v|
	COLOR_PAIRS[k] = v.compact.uniq
end

COLOR_PAIRS.delete(nil)

COLOR_FILTER = {
  whites: {
    parent_hex: '#f9f9f9',
    display_name: "Whites & Ivories",
    border: '1px solid #D8D8D8',
    children_colors: {
      white: '#ffffff',
      ivory: '#f2eeeb',
      candelight: '#f1eee9',
      ecru: '#dcd3cc'
    }
  },
  grays: {
    parent_hex: '#c7c7c7',
    display_name: "Grays",
    border: 'none',
    children_colors: {
      platinum:  '#c4ccce',
      ice:  '#a1a3b2',
      silver_spectrum: '#969694',
      silver:  '#5e5d5b',
      charcoal:  '#4e4d55',
      gray:  '#393939'
    }
  },

  pinks: {
    parent_hex: '#e1b4b6',
    display_name: "Pinks",
    border: 'none',
    children_colors: {
      blush:  '#f5ddd1',
      petal_pink:  '#d8cecc',
      pink:  '#dbbdbd',
      rose:  '#daacae',
      cerise:  '#dba6c2',
      shrimp:  '#ca9a9a',
      guava:  '#e28983',
      bubble_gum:  '#d36b74',
      hot_pink:  '#df46a8',
      pomegranate:  '#d6134f',
      fuchsia:  '#b8396e',
      watermelon:  '#8b4b59',
      magenta:  '#9b1f43',
      azalea:  '#83304a',
      sangria:  '#6b1e32'
    }
  },
  
  reds: {
    parent_hex: '#801c20',
    display_name: "Reds",
    border: 'none',
    children_colors: {
      cherry:  '#e10436',
      red:  '#ca2436',
      fire_red:  '#c02422',
      capri_red:  '#8b191e',
      claret:  '#7b383f',
      apple:  '#6a3133',
      burgundy:  '#4e1c24'
    }
  },
  oranges: {
    parent_hex: '#fdad6d',
    display_name: "Oranges & Corals",
    border: 'none',
    children_colors: {
      orange:  '#eaa92d',
      bright_orange:  '#ed9166',
      peach:  '#d69965',
      bali_peach:  '#d79b65',
      creamsicle:  '#d4975c',
      orange_crush:  '#e26829',
      persimmon:  '#d85e4b',
      coral:  '#d45745',
      tangerine:  '#a94229'
    }
  },
  yellows:  {
    display_name: "Yellows & Golds",
    parent_hex: '#d7b900',
    border: 'none',
    children_colors: {
      sunflower:  '#f3d752',
      bright_canary:  '#f4cf43',
      midas_gold:  '#dfc79b',
      gold:  '#dbb489',
      yellow:  '#d2d38f',
      buttercup:  '#d1bd5c',
      canary:  '#ceaa3a',
      golden:  '#a79277'
    }
  },
  browns:  {
    parent_hex: '#976816',
    display_name: "Browns & Tans",
    border: 'none',
    children_colors: {
      biscotti:  '#ddcfcf',
      straw:  '#cac2b5',
      bamboo:  '#c9c1b6',
      sand:  '#cdbaa9',
      latte:  '#cca5a0',
      champagne:  '#b28975',
      cinnamon:  '#b37055',
      mocha:  '#756158',
      chocolate:  '#6a5655',
      sienna:  '#7a342a',
      espresso:  '#4d423c',
      brown:  '#31302e'
    }
  },
  greens:  {
    parent_hex: '#2c6600',
    display_name: "Greens",
    border: 'none',
    children_colors: {
      meadow:  '#d8e2d7',
      seafoam:  '#bdd0cc',
      honeydew:  '#b7c9a1',
      key_lime:  '#c5d475',
      lime:  '#9fd573',
      clover:  '#80b599',
      peridot:  '#919f7e',
      kiwi:  '#949e5f',
      emerald:  '#019678',
      kelly:  '#136a26',
      sage:  '#6a7b71',
      pistachio:  '#606c54',
      mossy_oak:  '#645f49',
      jade:  '#3a7072',
      mermaid:  '#016160',
      hunter:  '#405e54',
      olive:  '#222b08',
      shamrock:  '#003d30',
      holly:  '#0f1d1d'
    }
  },
  turquoise:  {
    parent_hex: '#03c2be',
    display_name: "Turquoise & Teals",
    border: 'none',
    children_colors: {
      turquoise:  '#1894c7',
      mystic_teal:  '#1183b9',
      dark_turquoise:  '#0c95a7',
      gem: '#228185',
      teal_oasis:  '#106677',
      pacific:  '#1b5e79'
    }
  },
  blues:  {
    parent_hex: '#080079',
    display_name: "Blues",
    border: 'none',
    children_colors: {
      light_blue:  '#c8deeb',
      spa:  '#aedee0',
      cornflower:  '#88c5f2',
      tiffany_blue:  '#70c7d1',
      bali_blue:  '#5c7ea4',
      peacock:  '#4a6f8c',
      royal_blue:  '#4163b6',
      sky_blue:  '#2d6d9b',
      haze_blue:  '#505f7e',
      blue_slate:  '#4e5663',
      periwinkle:  '#3d4b72',
      marine:  '#271b9b',
      navy:  '#14154b',
      blue:  '#27324e',
      blue_velvet:  '#26273c',
      midnight:  '#021128'
    }
  },
  purples:  {
    parent_hex: '#683588',
    display_name: "Purples",
    border: 'none',
    children_colors: {
      light_lavender: '#c0a9c6',
      lavender:  '#b19dc0',
      heather:  '#8a739f',
      bali_lavender: '#877494',
      wisteria:  '#9a8194',
      plum:  '#77485a',
      wine:  '#5f3038',
      aubergine:  '#50233a',
      grape:  '#545071',
      purple_passion:  '#483958',
      lapis:  '#41325d',
      dark_eggplant: '#2c1e42',
      purple:  '#26172c'
    }
  },

  blacks:  {
    parent_hex: '#000000',
    display_name: "Blacks",
    border: 'none',
    children_colors: {
      black:  '#000000'
    }
  }
}



