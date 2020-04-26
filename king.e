note
	description: "Summary description for {KING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	KING

inherit
	ENTITY
create
	make

feature
	make
		do
			row := 1
			col := 1
		end
feature -- attributes
	row, col : INTEGER
feature -- queries
	move(input: TUPLE[ INTEGER_32,INTEGER_32]): BOOLEAN
		do
			Result := FALSE
			if input[1] ~ (row + 1) or input[1] ~ row or input[1] ~ (row - 1) then
				if input[2] ~ (col + 1) or input[2] ~ col or input[2] ~ (col - 1) then
					Result := TRUE
				end
			end
		end
feature -- commands
	set_loc(inp: TUPLE[INTEGER_32 , INTEGER_32])
		do
			row := inp.integer_item (1)
			col := inp.integer_item (2)
		end

end
