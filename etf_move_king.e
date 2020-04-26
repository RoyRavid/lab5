note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_KING
inherit
	ETF_MOVE_KING_INTERFACE
	rename
		out as king_out
		end
	COMMAND
	rename
		out as cmd_out
	select
		cmd_out
		 end
create
	make
feature -- command
	move_king(square: TUPLE[x: INTEGER_32; y: INTEGER_32])
		require else
			move_king_precond(square)
		local
			delta_row, delta_col: INTEGER
			no_error: BOOLEAN
    	do
			no_error := model.king.move(square) and not model.too_many_pieces (square) and not model.out_of_bounds (square)
			if no_error then
				if model.j < model.history.count and model.in_game then
					model.wipe_hist (model.j)
				end
				delta_row := square.integer_item (1) - model.king.row
				delta_col := square.integer_item (2) - model.king.col
				model.add_history (Current)
				model.set_args ([delta_row, delta_col])
				model.move_king (square)
				model.default_update
			elseif model.i ~ 0 and not model.in_game then
				model.set_init_string ("  ok:")
			else
				model.set_error_string ("  invalid move:")
			end
			push
    	end
     undo (delta: TUPLE[x: INTEGER_32; y: INTEGER_32])
        local
       		final_row, final_col: INTEGER
    	do
    		final_row := model.king.row - delta.integer_item (1)
    		final_col := model.king.col - delta.integer_item (2)
    		model.move_king ([final_row, final_col])
--    		push

    	end

  	redo (delta: TUPLE[x: INTEGER_32; y: INTEGER_32])
        local
       		final_row, final_col: INTEGER
    	do
    		final_row := model.king.row + delta.integer_item (1)
    		final_col := model.king.col + delta.integer_item (2)
    		model.move_king ([final_row, final_col])
--    		push
    	end

    push
    	do
    			etf_cmd_container.on_change.notify ([Current])
    	end
end
