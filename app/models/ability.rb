class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
      if user.role.eql?(User::ROLE[0])
        can :manage, :all
      else
        cannot :manage, :SecretCode
      end
  end
end
