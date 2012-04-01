class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :read, :all

    can :manage, [Advert, Comment], :user_id => user.id
    can :create, [Advert, Comment] if user.email?
    can [:update, :destroy], User, :id => user.id

    if user.role == "moderator"
      can :manage, [Advert, Comment]
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard
    end
    can :manage, :all if user.role == "admin"
  end
end
