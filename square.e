note
	description: "Summary description for {SQUARE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE
inherit
	ANY
	redefine
		out
		end
create
	make


feature
	make(l_item: STRING)
		do
			item := l_item
			create location.default_create
		end
feature -- attributes
	item : STRING
	location: TUPLE[INTEGER, INTEGER]
feature -- commands
	set_location(loc: TUPLE[INTEGER, INTEGER])
		do
			location := loc
		end
feature -- queries
	out: STRING
		do
			Result := item
		end

end
