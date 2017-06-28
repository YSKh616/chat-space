# DB設計

## users table
| Column | Type    | Options                                |
|:-------|--------:|:--------------------------------------:|
| name   | string  | index: true, null: false, unique: true |
| mail   | string  | null:false                             |

### Association
* has_many: groups, through: groups_users
* has_many: messages
* has_many: groups_users

## groups table
| Column | Type    | Options                               |
|:-------|--------:|:-------------------------------------:|
| name   | string  | index: true, null: false, unique: true|

### Association
* has_many: users, through: groups_users
* has_many: messages
* has_many: groups_users

## groups_users table
| Column   | Type    | Options           |
|:---------|--------:|:-----------------:|
| user_id  | integer | foreign_key: true |
| group_id | integer | foreign_key: true |

### Association
* belongs_to: user
* belongs_to: group

## messages table
| Column   | Type    | Options                            |
|:---------|--------:|:----------------------------------:|
| body     | text    | null: false                        |
| image    | string  | null: false                        |
| user_id  | integer | null: false, foreign_key: true     |
| group_id | integer | null: false, foreign_key: true     |

### Association
* belongs_to: user
* belongs_to: group
