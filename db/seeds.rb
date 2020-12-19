# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = Users::Operation::Create.call(params: { email: 'admin@panicboat.net', name: 'Administrator' })
statements = [{ effect: 'allow', actions: ['*'], resources: ['*'] }]
policy = Policies::Operation::Create.call(params: { name: 'admin', inline: true, owner: 'user', statements: statements })
MapUserPolicies::Operation::Create.call(params: { user_id: user[:model].id, policy_id: policy[:model].id })

#--------------------------------------------------------------------
# IAM
#--------------------------------------------------------------------
iam = Services::Operation::Create.call(params: { name: 'iam', description: '' })

## Role
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListRole',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetRole',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateRole',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'UpdateRole',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteRole',  description: '',  access_level: 'write' })
## Policy
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListPolicy',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetPolicy',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreatePolicy',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'UpdatePolicy',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeletePolicy',  description: '',  access_level: 'write' })
## MapRolePolicy
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListRolePolicy',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetRolePolicy',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateRolePolicy',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteRolePolicy',  description: '',  access_level: 'write' })

## Group
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListGroup',   description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetGroup',    description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateGroup', description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'UpdateGroup', description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteGroup', description: '',  access_level: 'write' })
## User
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListUser',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetUser',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateUser',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'UpdateUser',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteUser',  description: '',  access_level: 'write' })
## MapGroupUser
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListGroupUser',   description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetGroupUser',    description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateGroupUser', description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteGroupUser', description: '',  access_level: 'write' })

## MapGroupRole
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListGroupRole',   description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetGroupRole',    description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateGroupRole', description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteGroupRole', description: '',  access_level: 'write' })
## MapGroupPolicy
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListGroupPolicy',   description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetGroupPolicy',    description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateGroupPolicy', description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteGroupPolicy', description: '',  access_level: 'write' })

## MapUserRole
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListUserRole',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetUserRole',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateUserRole',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteUserRole',  description: '',  access_level: 'write' })
## MapUserPolicy
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'ListUserPolicy',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'GetUserPolicy',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'CreateUserPolicy',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: iam[:model].id, name: 'DeleteUserPolicy',  description: '',  access_level: 'write' })

#--------------------------------------------------------------------
# ADVERTISEMENTS
#--------------------------------------------------------------------
advertisements = Services::Operation::Create.call(params: { name: 'advertisements', description: '' })

## Agency
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListAgency',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetAgency',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateAgency',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateAgency',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteAgency',  description: '',  access_level: 'write' })

## Advertiser
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListAdvertiser',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetAdvertiser',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateAdvertiser',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateAdvertiser',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteAdvertiser',  description: '',  access_level: 'write' })

## Product
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListProduct',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetProduct',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateProduct',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateProduct',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteProduct',  description: '',  access_level: 'write' })

## Event
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListEvent',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetEvent',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateEvent',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateEvent',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteEvent',  description: '',  access_level: 'write' })

## Banner
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListBanner',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetBanner',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateBanner',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateBanner',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteBanner',  description: '',  access_level: 'write' })

## BannerDetail
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListBannerDetail',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetBannerDetail',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateBannerDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateBannerDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteBannerDetail',  description: '',  access_level: 'write' })

## Budget
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListBudget',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetBudget',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateBudget',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateBudget',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteBudget',  description: '',  access_level: 'write' })

## BudgetDetail
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListBudgetDetail',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetBudgetDetail',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateBudgetDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateBudgetDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteBudgetDetail',  description: '',  access_level: 'write' })

## Achievement
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListAchievement',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetAchievement',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateAchievement',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateAchievement',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteAchievement',  description: '',  access_level: 'write' })

## AchievementDetail
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListAchievementDetail',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetAchievementDetail',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateAchievementDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateAchievementDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteAchievementDetail',  description: '',  access_level: 'write' })

## Measurement
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListMeasurement',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetMeasurement',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateMeasurement',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateMeasurement',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteMeasurement',  description: '',  access_level: 'write' })

## MeasurementDetail
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'ListMeasurementDetail',    description: '',  access_level: 'list' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'GetMeasurementDetail',     description: '',  access_level: 'read' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'CreateMeasurementDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'UpdateMeasurementDetail',  description: '',  access_level: 'write' })
Actions::Operation::Create.call(params: { service_id: advertisements[:model].id, name: 'DeleteMeasurementDetail',  description: '',  access_level: 'write' })
