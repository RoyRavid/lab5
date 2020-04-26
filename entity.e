note
	description: "Summary description for {ENTITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENTITY

feature
	move(input: TUPLE [INTEGER, INTEGER]) : BOOLEAN
		deferred
			--allow each entity to move in its own way
		end
feature
	set_loc(inp: TUPLE[INTEGER_32 , INTEGER_32])
		deferred
		end
end
