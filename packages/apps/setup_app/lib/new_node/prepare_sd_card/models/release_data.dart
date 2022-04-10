class ReleaseData {
  final String url;
  final String assetsUrl;
  final String uploadUrl;
  final String htmlUrl;
  final int id;
  final String nodeId;
  final String tagName;
  final String targetCommitish;
  final String name;
  final bool draft;
  final bool prerelease;
  final String createdAt;
  final String publishedAt;
  final String tarballUrl;
  final String zipballUrl;
  final String body;

  ReleaseData({
    required this.url,
    required this.assetsUrl,
    required this.uploadUrl,
    required this.htmlUrl,
    required this.id,
    required this.nodeId,
    required this.tagName,
    required this.targetCommitish,
    required this.name,
    required this.draft,
    required this.prerelease,
    required this.createdAt,
    required this.publishedAt,
    required this.tarballUrl,
    required this.zipballUrl,
    required this.body,
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
