class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    # @plans = Plan.all @plansは最終的に定義済みの@week_daysに代入され使われる為生成しなくていい
    @plan = Plan.new
  end

  # indexメソッドでnewアクションが行われている為以下は必要ない
  # def new
  #   @plan = Plan.new
  # end
  

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:plan, :date)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    @plans = Plan.where(date: @todays_date..@todays_date + 7)

    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: plans, wdays: wdays[(@todays_date + x).wday]}
      @week_days.push(days)
    end
  end
end