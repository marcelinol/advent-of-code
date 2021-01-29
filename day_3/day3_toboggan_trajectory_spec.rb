require 'rspec'
require_relative 'day3_toboggan_trajectory'

describe 'Day 3' do
  MAP = <<~MAP
    #.....#.....#
    #....#....#.#
    ....#..#.....
    ..#.#...#.###
    #.###...#..##
  MAP

  let(:map) { MAP.split("\n") }

  context 'following a slope of right 3 and down 1' do
    it 'counts 2 tree encounters' do
      planner = TobogganTrajectoryPlanner.new(trajectory_map: map)

      expect(planner.count_tree_encounters(steps_to_the_right: 3, steps_down: 1)).to eq(3)
    end
  end

  context 'following a slope of right 1 and down 2' do
    it 'counts 2 tree encounters' do
      planner = TobogganTrajectoryPlanner.new(trajectory_map: map)

      expect(planner.count_tree_encounters(steps_to_the_right: 1, steps_down: 2)).to eq(1)
    end
  end

  # Just for reference
  TRAJECTORY_RIGHT_3_DOWN_1 = <<~TRAJECTORY
    #.....#.....#
    #...O#....#.#
    ....#..X.....
    ..#.#...#.X##
    X.###...#..##
  TRAJECTORY

  TRAJECTORY_RIGHT_1_DOWN_2 = <<~TRAJECTORY
    #.....#.....#
    #....#....#.#
    ..O.#..#.....
    ..#.#...#..##
    #.#X#...#..##
  TRAJECTORY
end