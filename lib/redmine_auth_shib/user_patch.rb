require_dependency 'user'

class User

  def self.login_or_create_from_shib(auth)

    user = self.find_by_login(auth["login"])
    unless user
      user = EmailAddress.find_by(address: auth["mail"]).try(:user)
      if user.nil? && Redmine::AuthShib.onthefly_creation?
        user = User.new()
        user.login = auth["login"]
        user.language = Setting.default_language
        user.mail = auth["mail"]
        user.firstname = auth["givenname"]
        user.lastname = auth["surname"]
        user.activate
        user.save!
        user.reload
      end
    end
    group_membership_from_shib(user, auth["entitlement"])
    user
  end
  def self.group_membership_from_shib(user, entitlement)
    if entitlement
      valid_entitlements = Array.new
      entitlements = entitlement.split(';')
      for ent in entitlements
        ents = ent.split(':')
        valid_entitlements.push(ents.last)
      end
      for group_name in valid_entitlements
        group = Group.find_by(lastname: group_name)
        unless group
          group = Group.new()
          group.lastname = group_name
          group.save!
          group.reload
        end
        begin
          group.users.append(user)
        rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end