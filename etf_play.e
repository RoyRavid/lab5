note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE


create
	make
feature -- command
	play(size: INTEGER_32)
		require else
			play_precond(size)
    	do
			-- perform some update on the model state
			if not model.in_game then
				model.board.make_filled (create {SQUARE}.make ("_"), size, size)

				model.play

			else
				model.set_error_string ("  game already started:")
			end
			etf_cmd_container.on_change.notify ([Current])

    	end

end
