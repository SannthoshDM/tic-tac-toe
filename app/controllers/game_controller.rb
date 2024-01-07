class GameController < ApplicationController
  before_action :initialize_board, only: [:index, :make_move]
  after_action :initialize_board, only: [:reset_game]

  def index
  end

  def make_move
    i = params[:i].to_i
    j = params[:j].to_i

    if @board[i][j].nil?
      if @current_player_name == 'first player'
        @board[i][j] = 'X' # Assuming the player is always 'X'
        @current_player_name = 'second player'
        session[:count] += 1
      else
        @board[i][j] = 'O' 
        @current_player_name = 'first player'
        session[:count] += 1
      end
      session[:current_player_name] = @current_player_name
      session[:board] = @board
      if session[:count] > 4
        check_wins
      end

      redirect_to action: 'index'
    else
      head :unprocessable_entity
    end
  end

  def check_across
    @board.each do|i|
      if i.all? {|j| j == 'X'}
        @win = "first player wins"
        break
      elsif i.all? {|j| j == 'O'}
        @win = "second player wins"
        break
      end
    end
  end

  def check_down
    arr = @board.flatten
    arr.each_with_index do |v,i|
      if v == 'X' && arr[i+3] == 'X' && arr[i+6] == 'X'
        @win = "first player wins"
        break
      elsif v == 'O' && arr[i+3] == 'O' && arr[i+6] == 'O'
        @win = "second player wins"
        break
      end 
    end
  end

  def check_diagonal
    center = @board[1][1]
    if (@board[0][0] == center && @board[2][2] == center) || (@board[0][2] == center && @board[2][0] == center)
      if center == 'X'
        @win = 'first player wins'
      else
        @win = 'second player wins'
      end
    end
  end

  def check_wins
    @win = nil
    if @win.nil?
      check_across
    end
    if @win.nil?
      check_down
    end
    if @win.nil?
      check_diagonal
    end
    if @win.nil? 
      if session[:count] == 9
        @win = "match ties"
      end
    else
      session[:win] = @win
    end
  end

  def reset_game
    session[:board] = Array.new(3) { Array.new(3, nil) }
    session[:current_player_name] = nil
    session[:count] = nil
    session[:win] = nil
    redirect_to action: 'index'
  end

  private

  def initialize_board
    @board = session[:board] || Array.new(3) { Array.new(3, ' ') }
    @current_player_name = session[:current_player_name] || 'first player'
    session[:board] = @board
    session[:current_player_name] = @current_player_name
    session[:count] = session[:count] || 0
    @win = session[:win]
  end
end
