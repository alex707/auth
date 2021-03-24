# version: 20210314175000

Sequel.migration do
  change do
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false

      primary_key [:filename]
    end

    create_table(:schema_seeds) do
      String :filename, :text=>true, :null=>false

      primary_key [:filename]
    end

    create_table(:users, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      String :name, :null=>false
      String :email, :null=>false
      String :password_digest, :null=>false
      DateTime :created_at, :size=>6, :null=>false
      DateTime :updated_at, :size=>6, :null=>false

      index [:email], :name=>:index_users_on_email, :unique=>true
    end

    create_table(:user_sessions, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      String :uuid, :null=>false
      foreign_key :user_id, :users, :type=>:Bignum, :null=>false, :key=>[:id]
      DateTime :created_at, :size=>6, :null=>false
      DateTime :updated_at, :size=>6, :null=>false

      index [:user_id], :name=>:index_user_sessions_on_user_id
      index [:uuid], :name=>:index_user_sessions_on_uuid
    end
  end
end
