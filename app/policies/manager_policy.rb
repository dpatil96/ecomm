class ManagerPolicy < ApplicationPolicy

    def users_list?
        user.role == 'manager'
    end
end