class ReleaseData {
  final String? url;
  final String? assetsUrl;
  final String? uploadUrl;
  final String? htmlUrl;
  final int? id;
  final String? nodeId;
  final String? tagName;
  final String? targetCommitish;
  final String? name;
  final bool? draft;
  final bool? prerelease;
  final String? createdAt;
  final String? publishedAt;
  final String? tarballUrl;
  final String? zipballUrl;
  final String? body;

  ReleaseData({
    this.url,
    this.assetsUrl,
    this.uploadUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.tagName,
    this.targetCommitish,
    this.name,
    this.draft,
    this.prerelease,
    this.createdAt,
    this.publishedAt,
    this.tarballUrl,
    this.zipballUrl,
    this.body,
  });

  ReleaseData.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        assetsUrl = json['assets_url'],
        uploadUrl = json['upload_url'],
        htmlUrl = json['html_url'],
        id = json['id'],
        nodeId = json['node_id'],
        tagName = json['tag_name'],
        targetCommitish = json['target_commitish'],
        name = json['name'],
        draft = json['draft'],
        prerelease = json['prerelease'],
        createdAt = json['created_at'],
        publishedAt = json['published_at'],
        tarballUrl = json['tarball_url'],
        zipballUrl = json['zipball_url'],
        body = json['body'];
}
