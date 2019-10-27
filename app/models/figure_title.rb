class FigureTitle < ActiveRecord::Base
  # add relationships here
  belongs_to :title
  belongs_to :figure
end
