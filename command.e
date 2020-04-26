note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND

feature -- commands
	undo (square: TUPLE[x: INTEGER_32; y: INTEGER_32])
		deferred

		end
	redo (square: TUPLE[x: INTEGER_32; y: INTEGER_32])
		deferred

		end


end
