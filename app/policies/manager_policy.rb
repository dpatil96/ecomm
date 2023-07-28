class ManagerPolicy < ApplicationPolicy

    def users_list?
        user.manager?
    end
end