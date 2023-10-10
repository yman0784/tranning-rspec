require 'rails_helper'

RSpec.describe Project, type: :model do
  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "Joe",
      last_name:  "Tester",
      email:      "joetester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(
      name: "Test Project",
    )

    new_project = user.projects.build(
    name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

    # 二人のユーザーが同じ名前を使うことは許可すること
    it "allows two users to share a project name" do
      user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

      user.projects.create(
      name: "Test Project",
      )

      other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email: "janetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      )

      other_project = other_user.projects.build(
        name: "Test_Project",
      )

      expect(other_project).to be_valid
    end

    it "returns a user's full name as a string" do
      user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "johndoe@example.com",
      )
      expect(user.name).to eq "John Doe"
    end

  end