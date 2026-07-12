<?php 
if(isset($_GET['id'])){
    $qry = $conn->query("SELECT * FROM `movie_list` where id = '{$_GET['id']}'");
    if($qry->num_rows > 0){
        $res = $qry->fetch_array();
        foreach($res as $k => $v){
            if(!is_numeric($k)){
                $$k = $v;
            }
        }
        $genre_qry = $conn->query("SELECT * FROM genre_list where id in ({$genres})");
        $genre_arr = [];
        if($genre_qry->num_rows > 0)
        $genre_arr = array_column($genre_qry->fetch_all(MYSQLI_ASSOC),'name');
        $genre_names = count($genre_arr) > 0 ? implode(", ",$genre_arr) : "N/A";
        $description = str_replace("\n","<br>",$description);
    }else{
    echo "<script>alert('Unknown Movie ID'); location.replace('./?page=movies');</script>";
    }
}
else{
    echo "<script>alert('Movie ID is required'); location.replace('./?page=movies');</script>";
}
?>
<style>
    @media screen {
        .show-print{
            display:none;
        }
    }
    img#movie-banner{
        height: 45vh;
        width: 20vw;
        object-fit: scale-down;
        object-position: center center;
    }
    .table.border-info tr, .table.border-info th, .table.border-info td{
        border-color:var(--info);
    }
</style>
<?php 
$success_rate = 0;
$success_perc = 0;
$count_reviews = $conn->query("SELECT id from review_list where movie_id ='{$id}'")->num_rows;
$overall_rating = $conn->query("SELECT SUM(rating) as total from review_list where movie_id ='{$id}'")->fetch_array()[0];
if($count_reviews  > 0){
    $success_rate = round($overall_rating / $count_reviews,2);
    $success_perc = number_format(($overall_rating / ($count_reviews * 5)) * 100);
}

?>
<div class="content py-3">
    <div class="card card-outline card-dark rounded-0">
        <div class="card-header rounded-0">
            <h5 class="card-title text-primary">Movie Details</h5>
        </div>
        <div class="card-body">
            <div class="container-fluid">
                <div id="outprint">
                    <fieldset>
                        <div class="row justify-content-center bg-gradiend-dark">
                            <div class="col-auto">
                                <img src="<?= validate_image($image_path) ?>" alt="Movie Cover" id="movie-banner">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <h2 class="text-navy text-center"><b><?= $title ?></b></h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <table class="table table-bordered border-info">
                                    <colgroup>
                                        <col width="30%">
                                        <col width="70%">
                                    </colgroup>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Directed By</th>
                                        <td><?= ucwords($director) ?></td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Written By</th>
                                        <td><?= ucwords($writter) ?></td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Actors</th>
                                        <td><?= ucwords($actors) ?></td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Produced By</th>
                                        <td><?= ucwords($produced) ?></td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Release Date</th>
                                        <td><?= date("F d, Y",strtotime($release_date)) ?></td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Genre</th>
                                        <td><?= $genre_names ?></td>
                                    </tr>
                                    <tr>
                                        <th class="text-muted text-white bg-gradient-info px-2 py-1">Predicted Success Rate:</th>
                                        <td> 
                                            <?php if($count_reviews  > 0): ?>
                                            <b><?= $success_rate ?>/5</b> <span class="text-muted">or</span> <b><?= $success_perc."%" ?></b>
                                            <?php else: ?>
                                                <span class="text-muted">No Reviews Listed yet</span>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                </table>
                                <h3 class="text-muted"><b>Description</b></h3>
                                <hr>
                                <p><?= $description ?></p>
                            </div>
                        </div>
                        
                    </fieldset>
                </div>
                <hr>
                <div class="rounded-0 mt-3">
                        <h3 class="text-muted"><b>Review/s:</b></h3>
                        <?php 
                        $reviews = $conn->query("SELECT r.*,c.email,c.avatar FROM review_list r inner join client_list c on r.client_id = c.id where r.movie_id = '{$id}' order by unix_timestamp(r.`date_created`) asc ");
                        ?>
                        <div id="review_list">
                            <?php while($row=$reviews->fetch_assoc()): ?>
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-8 col-lx-6">
                                    <div class="card card-outline card-primary shadow rounded-0">
                                        <div class="card-header py-1 rounded-0">
                                            <div class="row">
                                                <div class="col-1">
                                                    <img src="<?= validate_image($row['avatar']) ?>" alt="User Avatar" class="review-user-img">
                                                </div>
                                                <div class="col-9" style="line-height: .5em;">
                                                    <h4 class="card-title w-100"><b><?= $row['title'] ?></b></h4>
                                                    <small><span class="text-primary"><?= $row['email'] ?></span> <span class="mx-3"><?= date("Y-m-d H:i", strtotime($date_created)) ?></span></small>
                                                </div>
                                                <div class="col-2">
                                                    <h2 class="text-muted text-right"><?= $row['rating'] ?>/5</h2>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body rounded-0">
                                            <p><?= $row['comment'] ?></p>
                                            <?php if($_settings->userdata('id') > 0 && $row['client_id'] == $_settings->userdata('id')  && $_settings->userdata('login_type') != 1 ): ?>
                                            <div class="row">
                                                <div class="form-group col-md-12 text-right">
                                                     <button class="btn btn-danger btn-sm btn-flat delete_data" type="button" data-id='<?= $row['id'] ?>'>Delete</button>
                                                </div>
                                            </div>
                                            <?php endif; ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php endwhile; ?>
                        </div>
                        <?php if($reviews->num_rows <=0): ?>
                            <small class="tex-muted"><em>No Review Listed yet.</em></small>
                        <?php endif; ?>
                    <?php if($_settings->userdata('id') > 0 && $_settings->userdata('login_type') != 1): ?>
                        <?php 
                        $has_reviewed = $conn->query("SELECT * FROM `review_list` where movie_id ='{$id}' and client_id = '{$_settings->userdata('id')}' ")->num_rows;
                        if($has_reviewed <= 0):
                        ?>
                        <!-- Comment Form -->
                        <div class="card border shadow rounded-0 col-lg-6 col-md-8 col-sm-12 col-xs-12">
                            <div class="card-body">
                                <div class="contrainer-fluid">
                                    <form action="" id="comment-form">
                                        <input type="hidden" name="movie_id" value="<?= $id ?>">
                                        <input type="hidden" name="client_id" value="<?= $_settings->userdata('id') ?>">
                                        <div class="row">
                                            <div class="col-md-6 form-group">
                                                <label for="title" class="control-label text-muted">Title</label>
                                                <input type="text" class="form-control form-control-sm rounded-0" id="title" name="title" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 form-group">
                                                <label for="comment" class="control-label text-muted">Comment</label>
                                                <textarea rows="3" class="form-control form-control-sm rounded-0" id="comment" name="comment" required></textarea>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 text-center form-group">
                                                <button class="btn btn-primary btn-flat btn-sm" type="submit">Submit</button>
                                                <button class="btn btn-default btn-flat btn-sm" type="reset">Reset</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- End of Comment Form -->
                        <?php else: ?>
                            <center><small class="text-muted"><i>You have submitted your review for this movie.</i></small></center>
                        <?php endif; ?>

                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        $('.delete_data').click(function(){
            _conf("Are you sure to delete your review on this movie?","delete_review",[$(this).attr('data-id')])
        })
        $('#comment-form').submit(function(e){
            e.preventDefault();
            var _this = $(this)
            $('.pop-msg').remove()
            var el = $('<div>')
                el.addClass("pop-msg alert")
                el.hide()
            start_loader();
            $.ajax({
                url:_base_url_+"classes/Master.php?f=save_review",
                data: new FormData($(this)[0]),
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                dataType: 'json',
                error:err=>{
                    console.log(err)
                    alert_toast("An error occured",'error');
                    end_loader();
                },
                success:function(resp){
                    if(resp.status == 'success'){
                        location.reload();
                    }else if(!!resp.msg){
                        el.addClass("alert-danger")
                        el.text(resp.msg)
                        _this.prepend(el)
                    }else{
                        el.addClass("alert-danger")
                        el.text("An error occurred due to unknown reason.")
                        _this.prepend(el)
                    }
                    el.show('slow')
                    $('html,body,.modal').animate({scrollTop:0},'fast')
                    end_loader();
                }
            })
        })
    })
    function delete_review($id){
        start_loader();
        $.ajax({
            url:_base_url_+"classes/Master.php?f=delete_review",
            method:"POST",
            data:{id: $id},
            dataType:"json",
            error:err=>{
                console.log(err)
                alert_toast("An error occured.",'error');
                end_loader();
            },
            success:function(resp){
                if(typeof resp== 'object' && resp.status == 'success'){
                    location.reload();
                }else{
                    alert_toast("An error occured.",'error');
                    end_loader();
                }
            }
        })
    }
</script>



<div class="recommended-section mt-5">
    <h4 class="text-primary">Recommended Movies</h4>
    <div class="row">
        <?php
        // Get the genre(s) of the current movie
        $current_movie_genres_query = $conn->query("SELECT genres FROM movie_list WHERE id = '{$id}' LIMIT 1");
        if ($current_movie_genres_query && $current_movie_genres_query->num_rows > 0) {
            $current_movie_genres = $current_movie_genres_query->fetch_assoc()['genres'];
            $genre_ids = explode(',', $current_movie_genres); // Extract genres as an array

            // Create a SQL query to fetch recommended movies based on genres
            $genre_condition = implode(",", array_map('intval', $genre_ids));
            $recommended_movies_query = $conn->query(
                "SELECT * FROM movie_list 
                WHERE id != '{$id}' 
                AND (" . implode(" OR ", array_map(function($genre) {
                    return "FIND_IN_SET('$genre', genres)";
                }, $genre_ids)) . ") 
                LIMIT 4"
            );

            if ($recommended_movies_query && $recommended_movies_query->num_rows > 0) {
                while ($movie = $recommended_movies_query->fetch_assoc()) {
                    // Fetch genre names for the movie
                    $movie_genres = explode(',', $movie['genres']);
                    $genre_names_query = $conn->query(
                        "SELECT GROUP_CONCAT(name SEPARATOR ', ') AS genre_names FROM genre_list WHERE id IN (" . implode(",", array_map('intval', $movie_genres)) . ")"
                    );

                    $genre_names = $genre_names_query && $genre_names_query->num_rows > 0
                        ? $genre_names_query->fetch_assoc()['genre_names']
                        : "N/A";
        ?>
                    <div class="col-md-3 mb-3">
                        <div class="card shadow-sm h-100">
                            <img src="<?= validate_image($movie['image_path']) ?>" alt="Movie Cover" class="card-img-top" style="height: 200px; object-fit: cover;">
                            <div class="card-body">
                                <h5 class="card-title"><?= htmlspecialchars($movie['title']) ?></h5>
                                <p class="card-text text-muted">
                                    Genre: <?= htmlspecialchars($genre_names) ?>
                                </p>
                                <p class="card-text text-muted">
                                    Release Date: <?= date("F d, Y", strtotime($movie['release_date'])) ?>
                                </p>
                                <a href="./?page=movie_details&id=<?= $movie['id'] ?>" class="btn btn-primary btn-sm">View Details</a>
                            </div>
                        </div>
                    </div>
        <?php
                }
            } else {
                echo '<div class="col-12"><p class="text-muted">No recommended movies available at the moment.</p></div>';
            }
        } else {
            echo '<div class="col-12"><p class="text-muted">No recommended movies available at the moment.</p></div>';
        }
        ?>
    </div>
</div>
