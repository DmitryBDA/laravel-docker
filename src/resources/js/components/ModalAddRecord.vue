<template>
    <div>
        <div class="modal fade" id="modal-add-records">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Добавить запись</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true" ref="_close_modal_add_records">&times;</span>
                        </button>
                    </div>

                    <form @submit.prevent="saveRecords($event)" class="_form_add-records" :data-date="date">
                        <div class="card-body">
                            <div class="form-group">
                                <label>Время</label>
                            </div>
                            <p v-if="inputTime.length === 0">Добавьте новую запись</p>

                            <template v-for="arrErrors in errorMessage">
                              <small class="text-danger" v-for="message in arrErrors">{{message}}</small>
                            </template>

                            <template v-for="(item, idx) in inputTime">
                                <div class="input-group mb-3 _time_record">
                                    <input type="time" v-model="item.value" class="form-control">
                                    <input v-if="item.typeRecord" type="text" v-model="item.title" class="form-control">
                                    <div @click="inputDelete(idx)" class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-times"></i></span>
                                    </div>
                                </div>
                            </template>
                        </div>

                        <div class="card-footer">
                            <button @click="inputAdd(false)" type="button" class="btn btn-primary ml-0">Добавить</button>
                            <button @click="inputAdd(true)" type="button" class="btn btn-primary ml-0 ">Личное</button>
                            <button :disabled="isDisabled" type="submit" class="btn btn-primary mr-0 ">Сохранить</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <button style="display: none" data-toggle="modal" data-target="#modal-add-records" ref="_open_modal_add_record"></button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            inputTime: [
                {
                    typeRecord:false,
                    value:'00:00',
                    status: 1,
                    title: ''
                }
            ],
            isDisabled:false,
            date:'',
            errorMessage:[]
        }
    },
    methods: {
        inputAdd: function (type) {
            this.inputTime.push({
                typeRecord: type,
                value: '00:00',
                status: type ? 4 : 1,
                title: ''
            })
            this.errorMessage = []
            this.isDisabled = false
        },
        inputDelete(idx) {
            this.inputTime.splice(idx, 1)
            if (this.inputTime.length === 0) {
                this.isDisabled = true
            }
        },
        saveRecords(event){
             axios.post('/admin/records', {timeRecords:this.inputTime, date:this.date})
                 .then((response)=>{
                     this.$parent.showRecords()
                     this.$refs._close_modal_add_records.click()
                 })
                 .catch(err => {
                   if (err.response) {
                     this.errorMessage = err.response.data.errors
                   }
                 })
        },
    }

}
</script>
