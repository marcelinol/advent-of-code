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
      expect(TobogganTrajectoryPlanner.count_tree_encounters(MAP.split("\n"))).to eq(2)
    end
  end
end