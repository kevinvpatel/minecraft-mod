class Data {
  List<Category>? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json, String tag) {
    if (json[tag] != null) {
      category = <Category>[];
      json[tag].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

}


class Category {
  String? id;
  String? title;
  List<Categories>? categories;
  List<Versions>? versions;
  List<Files>? files;
  String? key;
  List<Screens>? screens;
  List<Recipes>? recipes;
  String? author;
  String? date;
  String? views;
  String? likes;
  String? downloads;
  String? description;

  Category(
      {this.id,
        this.title,
        this.categories,
        this.versions,
        this.files,
        this.key,
        this.screens,
        this.recipes,
        this.author,
        this.date,
        this.views,
        this.likes,
        this.downloads,
        this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['versions'] != null) {
      versions = <Versions>[];
      json['versions'].forEach((v) {
        versions!.add(Versions.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }

    key = json['key'];

    if (json['screens'] != null) {
      screens = <Screens>[];
      json['screens'].forEach((v) {
        screens!.add(Screens.fromJson(v));
      });
    }
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(Recipes.fromJson(v));
      });
    }
    author = json['author'];
    date = json['date'];
    views = json['views'];
    likes = json['likes'];
    downloads = json['downloads'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (versions != null) {
      data['versions'] = versions!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (screens != null) {
      data['screens'] = screens!.map((v) => v.toJson()).toList();
    }
    if (recipes != null) {
      data['recipes'] = recipes!.map((v) => v.toJson()).toList();
    }
    data['key'] = key;
    data['author'] = author;
    data['date'] = date;
    data['views'] = views;
    data['likes'] = likes;
    data['downloads'] = downloads;
    data['description'] = description;
    return data;
  }
}


///Categories Class
class Categories {
  String? categoryId;
  String? name;
  String? post;

  Categories({this.categoryId, this.name, this.post});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['name'] = name;
    data['post'] = post;
    return data;
  }
}


///Versions Class
class Versions {
  String? code;

  Versions({this.code});

  Versions.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['code'] = code;
    return data;
  }
}


///File Class
class Files {
  String? fileId;
  String? url;
  String? desc;
  String? downloads;

  Files({this.fileId, this.url, this.desc, this.downloads});

  Files.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
    url = json['url'];
    desc = json['desc'];
    downloads = json['downloads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['file_id'] = fileId;
    data['url'] = url;
    data['desc'] = desc;
    data['downloads'] = downloads;
    return data;
  }
}


///Screen Class
class Screens {
  String? url;

  Screens({this.url});

  Screens.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    return data;
  }
}


///Recipes Class
class Recipes {
  String? url;

  Recipes({this.url});

  Recipes.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    return data;
  }
}