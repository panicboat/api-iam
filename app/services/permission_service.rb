class PermissionService
  def initialize(user)
    @user = user
    @groups = Group.joins(:users).where(users: { id: user.id }) if user.present?
  end

  def all
    return [] if user.blank?

    user_roles | user_policies | group_roles | group_policies
  end

  private

  attr_reader :user

  def user_roles
    Policy.joins(:roles).joins(:users).where(users: { id: user.id })
  end

  def user_policies
    Policy.joins(:users).where(users: { id: user.id })
  end

  def group_roles
    return [] if groups.blank?

    Policy.joins(:roles).joins(:groups).where(groups: { id: groups.pluck(:id) })
  end

  def group_policies
    return [] if groups.blank?

    Policy.joins(:groups).where(groups: { id: groups.pluck(:id) })
  end
end
