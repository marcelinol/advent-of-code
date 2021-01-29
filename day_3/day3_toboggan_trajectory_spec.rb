require 'rspec'
require_relative 'day3_toboggan_trajectory'

describe 'Day 3' do
  MAP = <<~MAP
    #.....#.....#
    #....#....#.#
    ....#..#.....
    ..#.#...#.###
  MAP

  # Just for reference
  TRAJECTORY = <<~TRAJECTORY
    #.....#.....#
    #...O#....#.#
    ....#..X.....
    ..#.#...#.X##
  TRAJECTORY

  context 'following a slope of right 3 and down 1' do
    it 'counts 2 tree encounters' do
      planner = TobogganTrajectoryPlanner.new(steps_to_the_right: 3, steps_down: 1)

      expect(planner.count_tree_encounters(trajectory_map: MAP.split("\n"))).to eq(2)
    end
  end
end