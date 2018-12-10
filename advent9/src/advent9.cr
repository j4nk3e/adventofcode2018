module Advent9
	class Ring(T)
		property head : Node(T)
		property tail : Node(T)

		def initialize(element : T)
			n = Node(T).new element
			@head = n
			@tail = n
			n.after = n
			n.before = n
		end

		def insert(element : T)
			n = Node(T).new element
			t = @tail
			t.after = n
			n.before = t
			@head.before = n
			n.after = @head
		end

		def pop(): T
			t = @tail
			@tail = @tail.before
			@tail.after = @head
			@head.before = @tail
			return t.item
		end

		def left(num : Int64)
			num.times do
				@head = @tail
				@tail = @tail.before
			end
		end

		def right(num : Int64)
			num.times do
				@tail = @head
				@head = @head.after
			end
		end

		class Node(T)
			property item : T
			@after : Node(T)?
			@before : Node(T)?

			def initialize(@item : T)
			end

			def after : Node(T)
				return @after || itself
			end

			def before : Node(T)
				return @before || itself
			end

			def after=(@after : Node(T))
			end

			def before=(@before : Node(T))
			end
		end
	end

	player_count = 478_i64
	last_points = 7124000_i64
	player_points = Array(Int64).new player_count, do 0_i64 end
	marbles = Deque(Int64).new 0_i64
	last = 0_i64
	current_player = 0_i64
	while last < last_points
		last += 1_i64
		if last % 23_i64 == 0_i64
			player_points[current_player]+=last
			marbles.rotate! -8
			player_points[current_player] += marbles.pop
			marbles.rotate! 2
		else
			marbles << last
			marbles.rotate! 1
		end
		current_player = (current_player + 1_i64) % (player_count)
	end
	puts player_points.max
end
