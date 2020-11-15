module Permissions::Operation::Concerns
  class Show
    def initialize(user)
      @user = user
      @groups = Group.joins(:users).where(users: { id: user.id }) if user.present?
    end

    def all
      return [] if user.blank?

      user_roles | user_policies | group_roles | group_policies
    end

    private

    attr_reader :user, :groups

    def user_roles
      roles = Role.joins(:users).where(users: { id: user.id })
      Policy.joins(:roles).where(roles: { id: roles.pluck(:id) })
    end

    def user_policies
      Policy.joins(:users).where(users: { id: user.id })
    end

    def group_roles
      return [] if groups.blank?

      roles = Role.joins(:groups).where(groups: { id: groups.pluck(:id) })
      Policy.joins(:roles).where(roles: { id: roles.pluck(:id) })
    end

    def group_policies
      return [] if groups.blank?

      Policy.joins(:groups).where(groups: { id: groups.pluck(:id) })
    end
  end
end
