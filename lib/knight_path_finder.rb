require_relative "./00_tree_node.rb"
class KnightPathFinder
    attr_reader :root_node
    def initialize(start)
        @root_node = PolyTreeNode.new(start)
        @considered_positions = [start]
    end
   
    def self.valid_moves(pos)
        row, col = pos
        moves = []
        moves << [row + 2, col + 1]
        moves << [row + 2, col - 1]
        moves << [row - 2, col + 1]
        moves << [row - 2, col - 1]
        moves << [row + 1, col + 2]
        moves << [row - 1, col + 2]
        moves << [row + 1, col - 2]
        moves << [row - 1, col - 2]

        moves.select do |move|
            row, col = move
            row >= 0 && row <= 7 && col >= 0 && col <= 7
        end
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        new_moves = moves.reject do |move|
            @considered_positions.include?(move)
        end
        #new moves is an array that has all the valid moves that we haven't
        #conisdered yet

        @considered_positions.concat(new_moves)
        
        new_moves # [[1,2],[3,2]]
    end

    def build_move_tree
        start_node = root_node
        queue = []
        queue << start_node

        until queue.empty?
            current = queue.shift
            current_pos = current.value
            new_moves = new_move_positions(current_pos)
            new_moves.each do |move|
                queue << PolyTreeNode.new(move)
                current.add_child(queue.last)
            end
        end
        
    end
end