class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new
    case controller_namespace
      when "Admin"
        if user.admin?
          can :manage, :all
          #can :access, :admin
          can :admin
        end
      else
        can :read, :all
        can :update, User,id: user.id
        can [:update, :destroy], [Like, Comment, Rating], user_id: user.id
      end
    end
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
