<div class="col-12">
    <div class="row my-5 justify-content-center">
        <div class="col-md-5 mb-4 mb-md-0">
            <div class="card border-0 shadow-lg rounded-3" style="border-top: 4px solid #6f42c1;">
                <div class="card-header bg-white border-0 py-3">
                    <h4 class="card-title m-0 text-center" style="color: #6f42c1;">
                        <i class="fas fa-info-circle me-2"></i>Contact Information
                    </h4>
                </div>
                <div class="card-body">
                    <dl class="m-0">
                        <dt class="text-muted mb-1"><i class="fas fa-envelope me-2"></i>Email</dt>
                        <dd class="ps-4 mb-3"><?= $_settings->info('email') ?></dd>
                        
                        <dt class="text-muted mb-1"><i class="fas fa-phone me-2"></i>Contact #</dt>
                        <dd class="ps-4 mb-3"><?= $_settings->info('contact') ?></dd>
                        
                        <dt class="text-muted mb-1"><i class="fas fa-map-marker-alt me-2"></i>Location</dt>
                        <dd class="ps-4 mb-0"><?= $_settings->info('address') ?></dd>
                    </dl>
                </div>
            </div>
        </div>
        
        <div class="col-md-7">
            <div class="card border-0 shadow-lg rounded-3" style="border-top: 4px solid #6f42c1;">
                <div class="card-body p-4">
                    <h2 class="text-center mb-3" style="color: #6f42c1;">
                        <i class="fas fa-paper-plane me-2"></i>Message Us
                    </h2>
                    <center><hr style="width: 80px; height: 3px; background: linear-gradient(90deg, #6f42c1, #0dcaf0); border: none;"></center>
                    
                    <?php if($_settings->chk_flashdata('pop_msg')): ?>
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle me-2"></i> <?= $_settings->flashdata('pop_msg') ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <script>
                            $(function(){
                                $('html, body').animate({scrollTop:0})
                            })
                        </script>
                    <?php endif; ?>
                    
                    <form action="" id="message-form" class="mt-4">
                        <input type="hidden" name="id">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="fullname" name="fullname" required placeholder="John Smith">
                                    <label for="fullname"><i class="fas fa-user me-2"></i>Full Name</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="contact" name="contact" required placeholder="xxxxxxxxxxxxx">
                                    <label for="contact"><i class="fas fa-phone me-2"></i>Contact #</label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-floating">
                                    <input type="email" class="form-control" id="email" name="email" required placeholder="xxxxxx@xxxxxx.xxx">
                                    <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                                    <textarea name="message" id="message" class="form-control" style="height: 120px" required placeholder="Write your message here"></textarea>
                                    <label for="message"><i class="fas fa-comment me-2"></i>Message</label>
                                </div>
                            </div>
                            <div class="col-12 text-center mt-3">
                                <button class="btn btn-primary rounded-pill px-4 py-2" style="
                                    background: linear-gradient(90deg, #6f42c1, #0dcaf0);
                                    border: none;
                                    min-width: 200px;
                                ">
                                    <i class="fas fa-paper-plane me-2"></i>Send Message
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function(){
        $('#message-form').submit(function(e){
            e.preventDefault();
            var _this = $(this)
            $('.pop-msg').remove()
            var el = $('<div>')
                el.addClass("pop-msg alert")
                el.hide()
            start_loader();
            $.ajax({
                url:_base_url_+"classes/Master.php?f=save_message",
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
                    $('html, body').animate({scrollTop:0},'fast')
                    end_loader();
                }
            })
        })
    })
</script>