class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #create new user(guest) if current_user returns nil

    if user.roles.size == 0 #guest user
      can :read, User
      can :create, User
    end
    if user.is? :standard #standard user
      can :manage, User, :id => user.id
      can :read, User
    end
  end
end
