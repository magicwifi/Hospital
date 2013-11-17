class ActivitiesController < ApplicationController
  def index
    user = User.find_by_name(params[:member_name])
    course = Course.where(:user_id => user.id, :name => params[:course_name]).first
    @activities = Activity.where(course_id: course.id).order("created_at desc")
  end

  def timeline
    @groups = []
    first = Activity.first.created_at
    date = Time.zone.now
    while first < date do
      @groups << Activity.within_range(date).reverse.group_by(&:course_id)
      date -= 30.days
    end
  end
end
