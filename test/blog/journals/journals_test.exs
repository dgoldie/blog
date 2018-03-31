defmodule Blog.JournalsTest do
  use Blog.DataCase

  alias Blog.Journals

  describe "posts" do
    alias Blog.Journals.Post

    @valid_attrs %{body: "some body", published: true, title: "some title"}
    @update_attrs %{body: "some updated body", published: false, title: "some updated title"}
    @invalid_attrs %{body: nil, published: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journals.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Journals.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Journals.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Journals.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.published == true
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Journals.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.body == "some updated body"
      assert post.published == false
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Journals.update_post(post, @invalid_attrs)
      assert post == Journals.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Journals.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Journals.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Journals.change_post(post)
    end
  end
end
