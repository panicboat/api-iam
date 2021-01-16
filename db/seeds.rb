# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

services = Service.create([
                            { id: Identity.uuid(Service), name: 'iam', description: '' },
                            { id: Identity.uuid(Service), name: 'advertisements', description: '' },
                          ])

#--------------------------------------------------------------------
# IAM
#--------------------------------------------------------------------
Action.create([
                ## Group
                { id: Identity.uuid(Action), service: services.first, name: 'ListGroup',   description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetGroup',    description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateGroup', description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'UpdateGroup', description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteGroup', description: '',  access_level: 'write' },
                ## MapGroupPolicy
                { id: Identity.uuid(Action), service: services.first, name: 'ListGroupPolicy',   description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetGroupPolicy',    description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateGroupPolicy', description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteGroupPolicy', description: '',  access_level: 'write' },
                ## MapGroupRole
                { id: Identity.uuid(Action), service: services.first, name: 'ListGroupRole',   description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetGroupRole',    description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateGroupRole', description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteGroupRole', description: '',  access_level: 'write' },
                ## MapGroupUser
                { id: Identity.uuid(Action), service: services.first, name: 'ListGroupUser',   description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetGroupUser',    description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateGroupUser', description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteGroupUser', description: '',  access_level: 'write' },
                ## MapRolePolicy
                { id: Identity.uuid(Action), service: services.first, name: 'ListRolePolicy',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetRolePolicy',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateRolePolicy',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteRolePolicy',  description: '',  access_level: 'write' },
                ## MapUserPolicy
                { id: Identity.uuid(Action), service: services.first, name: 'ListUserPolicy',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetUserPolicy',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateUserPolicy',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteUserPolicy',  description: '',  access_level: 'write' },
                ## MapUserRole
                { id: Identity.uuid(Action), service: services.first, name: 'ListUserRole',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetUserRole',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateUserRole',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteUserRole',  description: '',  access_level: 'write' },
                ## Policy
                { id: Identity.uuid(Action), service: services.first, name: 'ListPolicy',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetPolicy',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreatePolicy',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'UpdatePolicy',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeletePolicy',  description: '',  access_level: 'write' },
                ## Role
                { id: Identity.uuid(Action), service: services.first, name: 'ListRole',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetRole',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateRole',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'UpdateRole',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteRole',  description: '',  access_level: 'write' },
                ## User
                { id: Identity.uuid(Action), service: services.first, name: 'ListUser',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.first, name: 'GetUser',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.first, name: 'CreateUser',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'UpdateUser',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.first, name: 'DeleteUser',  description: '',  access_level: 'write' },
              ])

#--------------------------------------------------------------------
# ADVERTISEMENTS
#--------------------------------------------------------------------
Action.create([
                ## Achievement
                { id: Identity.uuid(Action), service: services.second, name: 'ListAchievement',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetAchievement',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateAchievement',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateAchievement',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteAchievement',  description: '',  access_level: 'write' },
                ## AchievementDetail
                { id: Identity.uuid(Action), service: services.second, name: 'ListAchievementDetail',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetAchievementDetail',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateAchievementDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateAchievementDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteAchievementDetail',  description: '',  access_level: 'write' },
                ## Advertiser
                { id: Identity.uuid(Action), service: services.second, name: 'ListAdvertiser',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetAdvertiser',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateAdvertiser',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateAdvertiser',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteAdvertiser',  description: '',  access_level: 'write' },
                ## Agency
                { id: Identity.uuid(Action), service: services.second, name: 'ListAgency',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetAgency',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateAgency',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateAgency',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteAgency',  description: '',  access_level: 'write' },
                ## Banner
                { id: Identity.uuid(Action), service: services.second, name: 'ListBanner',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetBanner',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateBanner',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateBanner',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteBanner',  description: '',  access_level: 'write' },
                ## BannerDetail
                { id: Identity.uuid(Action), service: services.second, name: 'ListBannerDetail',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetBannerDetail',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateBannerDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateBannerDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteBannerDetail',  description: '',  access_level: 'write' },
                ## Budget
                { id: Identity.uuid(Action), service: services.second, name: 'ListBudget',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetBudget',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateBudget',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateBudget',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteBudget',  description: '',  access_level: 'write' },
                ## BudgetDetail
                { id: Identity.uuid(Action), service: services.second, name: 'ListBudgetDetail',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetBudgetDetail',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateBudgetDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateBudgetDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteBudgetDetail',  description: '',  access_level: 'write' },
                ## Campaign
                { id: Identity.uuid(Action), service: services.second, name: 'ListCampaign',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetCampaign',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateCampaign',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateCampaign',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteCampaign',  description: '',  access_level: 'write' },
                ## Event
                { id: Identity.uuid(Action), service: services.second, name: 'ListEvent',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetEvent',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateEvent',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateEvent',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteEvent',  description: '',  access_level: 'write' },
                ## Measurement
                { id: Identity.uuid(Action), service: services.second, name: 'ListMeasurement',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetMeasurement',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateMeasurement',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateMeasurement',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteMeasurement',  description: '',  access_level: 'write' },
                ## MeasurementDetail
                { id: Identity.uuid(Action), service: services.second, name: 'ListMeasurementDetail',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetMeasurementDetail',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateMeasurementDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateMeasurementDetail',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteMeasurementDetail',  description: '',  access_level: 'write' },
                ## Product
                { id: Identity.uuid(Action), service: services.second, name: 'ListProduct',    description: '',  access_level: 'list' },
                { id: Identity.uuid(Action), service: services.second, name: 'GetProduct',     description: '',  access_level: 'read' },
                { id: Identity.uuid(Action), service: services.second, name: 'CreateProduct',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'UpdateProduct',  description: '',  access_level: 'write' },
                { id: Identity.uuid(Action), service: services.second, name: 'DeleteProduct',  description: '',  access_level: 'write' },
              ])
