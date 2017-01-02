class TwitterController < ApplicationController
  def midday
    numbers = PickThree.wheel('midday')
    $twitter.update("Today's drawing: #{numbers.join(', ')} #KYPick3")
    render status: 204
  end

  def evening
    numbers = PickThree.wheel('evening')
    $twitter.update("Tonight's drawing: #{numbers.join(', ')} #KYPick3")
    render status: 204
  end
end
