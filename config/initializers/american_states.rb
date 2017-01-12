american_states = Spree::State.where(country_id: 232)
AMERICAN_STATES = american_states.reject { |s| ["AP", "AA", "AE"].include? (s.abbr) }


# HASH VERION:

# AMERICAN_STATES = {}

# american_states.each_with_index  do |state, i| 
# 	AMERICAN_STATES["#{american_states[i].name}"] = american_states[i].abbr
# end